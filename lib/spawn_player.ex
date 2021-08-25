defmodule Blackmore.SpawnPlayer do
  def start() do
    spawn(__MODULE__, :player, [%{song: nil}])
  end

  def player(%{song: title}) do
    receive do
      {:select, new_song} ->
        player(%{song: new_song})
      {:listen, client} ->
        send(client, {:now_playing, title})
        player(%{song: title})
      {:stop} -> exit(:stop)
    end
  end

  def select_song(pid, title), do: send(pid, {:select, title})

  def stop(pid), do: send(pid, {:stop})
end
