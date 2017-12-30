# frozen_string_literal: true

RSpec.shared_context "socket", shared_context: :meta_data do
  # Sanitize a mock game loop
  def spec_socket_server(debug: false, &block)
    game = Game.instance

    SpecHelperFunctions.suppress_output(override: debug) do
      game.run(port: "9017") do |s|
        yield(s)
        s.stop_event_loop
      end
    end
    game.clear_connection_pool
  end

  def populate_connection_pool(number_of_connections: 5)
    build_list(:player_connection, number_of_connections)
  end

  def stub_connection_unbind(connection)
    allow(connection.player).to(
      receive(:close_connection).and_wrap_original do |m, *args|
        connection.unbind
      end
    )
  end

  def expect_movement(subject, dest_x, dest_y)
    movement_setup
    send_player_to_area_center(@player)

    expect(@player.room.x_coord).to be(0)
    expect(@player.room.y_coord).to be(0)

    subject.new(@player).call

    expect(@player.room.x_coord).to be(dest_x)
    expect(@player.room.y_coord).to be(dest_y)
  end

  def movement_setup
    @area = Area.first || create(:area)
    @connection = build(:player_connection)
    @player = @connection.player
    @coord_range = @area.coord_index_range
  end

  def send_player_to_area_center(player)
    player.room = Room.where("x_coord = ? AND y_coord = ?", 0, 0).first
    player.save!
  end
end
