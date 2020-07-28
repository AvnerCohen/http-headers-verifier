module HttpHeadersUtils

    class << self
        attr_accessor :verbose
    end

    def self.bold(str)
        "\e[1m#{str}\e[22m"
    end

end