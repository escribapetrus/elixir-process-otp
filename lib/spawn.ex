defmodule Blackmore.SpawnPlayer do
  def start() do
    spawn(__MODULE__, :player, [%{song: nil}])
  end

  def player(%{song: title}) do
    receive do
      {:select, new_song} ->
        IO.inspect("Song selected: #{new_song}")
        player(%{song: new_song})
      {:listen, speaker} ->
        send(speaker, {:play, title})
        player(%{song: title})
      {:stop} -> exit(:stop)
    end
  end

  def select_song(pid, title), do: send(pid, {:select, title})

  def stop(pid), do: send(pid, {:stop})

  def listen(pid) do
    send(pid, {:listen, speaker()})
  end

  def speaker() do
    spawn(fn ->
      receive do
        {:play, title} ->
          IO.puts("Playing in speaker: #{title}")
          title
        after 500 -> exit(:stop)
      end
    end)
  end

end
