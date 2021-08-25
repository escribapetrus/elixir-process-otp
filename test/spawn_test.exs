defmodule Blackmore.SpawnTest do
  use ExUnit.Case, async: true
  alias Blackmore.SpawnPlayer, as: Player
  import :timer, only: [sleep: 1]

  setup do
    player = Player.start()

    %{player: player}
  end

  test "changes song currently playing", %{player: player} do
    Player.select_song(player, "Child in Time")
    assert Process.alive?(player)
  end

  test "sends song to speaker", %{player: player} do
    Player.select_song(player, "Child in Time")
    Player.listen(player)
    assert Process.alive?(player)
  end


  test "shuts down player", %{player: player} do
    assert Process.alive?(player)
    Player.stop(player)

    sleep 500
    refute Process.alive?(player)
  end
end
