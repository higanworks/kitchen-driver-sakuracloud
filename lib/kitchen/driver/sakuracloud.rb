require 'kitchen/driver/sakuracloud_version'
require 'kitchen'
require 'fog/sakuracloud'

module Kitchen
  module Driver
    class Sakuracloud < Kitchen::Driver::Base
      kitchen_driver_api_version 2

      plugin_version Kitchen::Driver::SAKURACLOUD_VERSION

      default_config :api_token do
        ENV['SAKURACLOUD_API_TOKEN']
      end

      default_config :api_token_secret do
        ENV['SAKURACLOUD_API_TOKEN_SECRET']
      end

      default_config :api_zone, nil
      default_config :serverplan, '1001'             # 1 Core 1 GB
      default_config :sourcearchive , "112700955889" #ubuntu14.04
      default_config :sshkey_id do
        ENV['SAKURACLOUD_SSH_KEYID']
      end
      default_config :diskplan , 4                   # ssd
      default_config :size_mb , 20480                # 20GB

      def create(state)
        server = create_server
        state[:id] = server.id
        state[:hostname] = server.interfaces.first["IPAddress"]
      end

      def destroy(state)
        destroy_server(state[:id]) if state[:id]
      end

      def create_server
        raise Kitchen::ActionFailed "" unless config[:sshkey_id]
        begin
        server = compute.servers.create(
          :name  => instance.name,
          :sshkey => config[:sshkey_id],
          :serverplan => config[:serverplan],
          :volume => {
            :diskplan => config[:diskplan],
            :size_mb => config[:size_mb],
            :sourcearchive => config[:sourcearchive]
          },
          :boot => true
        )
        server
      end

      def destroy_server(id)
        logger.debug "Trying to delete #{id} ..."
        begin
          server = compute.servers.get(id)
          server.stop(true)
          server.reload

          logger.debug("Waiting #{id} until down ... (in 15 sec)")
          3.times do
            break if server.instance["Status"] == "down"
            sleep 5
            server.reload
          end

          server.delete(true)
        rescue Excon::Errors::HTTPStatusError => e
          logger.error JSON.parse(e.response.body)
          raise e unless e.response.status == 404
        end
      end

      private
      def compute
        return @compute if @compute
        @compute = Fog::Compute::SakuraCloud.new(
          sakuracloud_api_token: config[:api_token],
          sakuracloud_api_token_secret: config[:api_token_secret],
          api_zone: config[:api_zone]
        )
        @compute
      end
    end
  end
end
