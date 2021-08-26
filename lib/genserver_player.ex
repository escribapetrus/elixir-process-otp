defmodule Blackmore.GenserverPlayer do
  use GenServer

  ## Client API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def select_song(pid, title) do
    GenServer.cast(pid, {:select_song, title})
  end

  def listen(pid) do
    GenServer.call(pid, {:listen})
  end

  def crash(pid) do
    GenServer.cast(pid, {:crash})
  end

  ## Server callbacks
  @impl true
  def init(:ok) do
    {:ok, %{song: nil}}
  end

  @impl true
  def handle_cast({:select_song, title}, song) do
    {:noreply, %{song | song: title}}
  end

  @impl true
  def handle_cast({:crash}, _state) do
    {:noreply, %{song: 1/0}}
  end

  @impl true
  def handle_call({:listen}, _from, %{song: title}) do
    {:reply, title, %{song: title}}
  end


  @impl true
  def handle_info(_message, state) do
    IO.inspect("Received a message, but don't know what to do")
    {:noreply, state}
  end
end
