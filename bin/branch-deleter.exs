#! /usr/bin/env elixir
defmodule GitBranchDeleter do
  @moduledoc """
  Interactively traverse all branches in the current repo and ask for confirmation
  on whether or not to delete them.
  """

  def run do
    unless in_repo?() do
      raise "not in a git repo"
    end

    {branches, _} = cmd("git branch")
    branches = String.split(branches, "\n")
    branches = Enum.map(branches, &String.trim/1)
    branches = Enum.filter(branches, fn branch -> branch != "" end)

    branches =
      Enum.map(branches, fn
        "* " <> branch -> branch
        branch -> branch
      end)

    for branch <- branches, branch not in ~w(main master) do
      if confirm("Delete #{IO.ANSI.format([:green, branch, :reset])}?") do
        case cmd("git branch -D #{branch}") do
          {_, 0} -> :ok
          {error, _} -> raise("unable to delete: #{error}")
        end
      end
    end
  end

  defp in_repo? do
    {_, code} = cmd("git status")
    code == 0
  end

  defp confirm(message) do
    case IO.gets("#{message} #{IO.ANSI.format([:faint, "[y/N]: ", :reset])}") do
      :eof -> false
      {:error, reason} -> raise("unable to read input: #{inspect(reason)}")
      resp -> Regex.match?(~r/y/i, resp)
    end
  end

  defp cmd(command) do
    [bin | args] = String.split(command)
    System.cmd(bin, args, stderr_to_stdout: true)
  end
end

GitBranchDeleter.run()
