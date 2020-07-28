class NaiveCookie
    # Super naive cookie implementation
    # It is not meant in any way to check the validity of the cookie
    # It is only meant to check specific properties of cookies that are assumed to be present.

    def initialize(cookie_str)
        @data = cookie_str.split("; ").map{ |s|
            s.index('=') ? s.split('=') : [s, true]
        }.to_h
    end

    def validate!(rules)
        errors = []

        if rules.key?("Path") && self.path != rules["Path"]
            errors.push(error("Path #{self.path} not matching #{rules["Path"]}."))
        end

        if rules.key?("Secure") && self.secure? != rules["Secure"]
            errors.push(error("Cookie not secure."))
        end

        if rules.key?("HttpOnly") && self.http_only? != rules["HttpOnly"]
            errors.push(error("Cookie expected to be set as HttpOnly."))
        end

        if rules.key?("SameSite") && self.same_site != rules["SameSite"]
            errors.push(error("SameSite #{self.same_site} not matching #{rules["SameSite"]}."))
        end

        if errors.length > 0
            return errors
        else
            return nil
        end
    end

    def error(text)
        return "\t\t👺   #{text}"
    end

    def to_s
        "#{self.name}, #{self.path}"
    end

    def secure?
        !@data.keys.find{ |item| item.downcase == "secure"}.nil?
    end

    def http_only?
        !@data.keys.find{ |item| item.downcase == "httponly"}.nil?
    end

    def same_site
        @data[@data.keys.find{ |item| item.downcase == "samesite"}]
    end

    def path
        @data[@data.keys.find{ |item| item.downcase == "path"}]
    end

    def name
        @data.keys[0]
    end

    def expires
        @data[@data.keys.find{ |item| item.downcase == "expires"}]
    end
end
