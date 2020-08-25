require_relative './http_headers_utils'

module HttpHeadersValidations

    def self.report(text, failed, icon)
        if failed || HttpHeadersUtils.verbose
            puts "\t#{icon} #{text}"
        end
    end

    def self.assert_expected_header(expected_header, expected_value, actual_value)
        if (!actual_value.nil? && expected_value.is_a?(Regexp) && actual_value.match?(expected_value)) ||
            (expected_value.to_s == actual_value.to_s)
            failed = false
            text = "Expected Header '#{expected_header}' matched!"
        else
            failed = true
            text = "Expected Header '#{HttpHeadersUtils.bold(expected_header)}' failed! '#{expected_value}' #{HttpHeadersUtils.bold('was')} '#{actual_value}'."
        end
        icon = failed ? "🛑" : "🍏"

        report(text, failed, icon)
    
        return text if failed 
    end
    
    def self.assert_extra_header(actual_header, actual_value, ignored_headers, avoid_headers)
    
        if avoid_headers.include? actual_header.downcase
            icon = "🛑"
            failed = true
            text = "Extra Header '#{actual_header}' is not allowed!"
        elsif ignored_headers.include? actual_header.downcase
            icon = "🍏"
            failed = false
            text = "Extra Header '#{actual_header}' marked for ignore!"
        else
            icon = "⚠️"
            failed = false
            text = "Warning: Extra Header '#{HttpHeadersUtils.bold(actual_header)}' with value '#{actual_value}' was unexpected."
        end

        report(text, failed, icon)
        
        return text if failed 
    end
    
    def self.assert_cookie_value(parsed_cookie, cookie_rules)
        if cookie_rules[parsed_cookie.name]
            valid_cookie = parsed_cookie.validate!(cookie_rules[parsed_cookie.name])
            if valid_cookie.nil?
                failed = false
                text = "Cookie '#{parsed_cookie.name}' passed verification!"
            else
                failed = true
                text = "Invalid cookie config '#{HttpHeadersUtils.bold(parsed_cookie.name)}':\n #{valid_cookie.join("\n")}"
            end
        else
            failed = true
            text = "Missing config for cookie '#{HttpHeadersUtils.bold(parsed_cookie.name)}'."
        end
        icon = failed ? "🛑" : "🍏"

        report(text, failed, icon)
        return [text, failed]
    end

end