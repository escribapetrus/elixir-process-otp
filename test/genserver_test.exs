defmodule Blackmore.GenserverPlayerTest do
  use ExUnit.Case, async: true
  alias Blackmore.GenserverPlayer, as: Player

  setup do
    player = start_supervised!(Player)
    %{player: player}
  end

  test "changes song", %{player: player} do
    Player.select_song(player, "Gates of Babylon")
    assert Player.listen(player) == "Gates of Babylon"
  end
end
