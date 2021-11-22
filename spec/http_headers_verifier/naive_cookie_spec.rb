require 'rspec'

require './lib/naive_cookie'

SAME_SITE_CONFIG = 'test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; Secure; HttpOnly; SameSite=Lax'

BASE_COOKIE_STR = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT"

describe NaiveCookie do

    describe "NaiveCookie.secure?" do
        it "should mark cookie as non secure if secure is missing" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; HttpOnly; SameSite=Lax"
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.secure?).to eq(false)
        end
        it "should mark cookie as secure if secure is present" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; Secure; HttpOnly; SameSite=Lax"
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.secure?).to eq(true)

        end
        it "should mark cookie as secure ignoring case" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; secure; HttpOnly; SameSite=Lax"
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.secure?).to eq(true)

        end
    end

    describe "NaiveCookie.http_only?" do
        it "should not mark cookie as http_only if http_only is missing" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; SameSite=Lax"
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.http_only?).to eq(false)
        end
        it "should mark cookie as http_only if http_only is present" do
            cookie_str = SAME_SITE_CONFIG
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.http_only?).to eq(true)

        end
        it "should mark cookie as http_only if http_only is present, ignoring case" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; httponly; SameSite=Lax"
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.http_only?).to eq(true)

        end
    end

    describe "NaiveCookie.same_site" do
        it "should return nil if samesite is missing" do
            cookie_str = BASE_COOKIE_STR
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.same_site).to eq(nil)
        end
        it "should return SameSite config" do
            cookie_str = SAME_SITE_CONFIG
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.same_site).to eq("Lax")

        end
        it "should return SameSite config, regardless of case" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; httponly; samesite=Strict"
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.same_site).to eq("Strict")

        end
    end

    describe "NaiveCookie.name" do
        it "should return cookiename" do
            cookie_str = BASE_COOKIE_STR
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.name).to eq("test_cookie_name")
        end
    end

    describe "NaiveCookie.path" do
        it "should return cookie path" do
            cookie_str = BASE_COOKIE_STR
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.path).to eq("/")
        end

        it "should return cookie path, ignore case" do
            cookie_str = BASE_COOKIE_STR
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.path).to eq("/")
        end

    end

    describe "NaiveCookie.expires" do
        it "should return cookie expires" do
            cookie_str = BASE_COOKIE_STR
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.expires).to eq("Tue, 11 Aug 2020 07:17:12 GMT")
        end
        it "should return cookie expires, ignoring case" do
            cookie_str = BASE_COOKIE_STR
            parsed_cookie = NaiveCookie.new(cookie_str)
            expect(parsed_cookie.expires).to eq("Tue, 11 Aug 2020 07:17:12 GMT")
        end

    end

    describe "NaiveCookie.validate!" do
        it "should fail if non secure required to be secure" do
            cookie_str = BASE_COOKIE_STR
            rules = {"Secure" => true}
            parsed_cookie = NaiveCookie.new(cookie_str)
            validation_results = parsed_cookie.validate!(rules)
            expect(validation_results.length).to eq(1)
        end
        it "should not if secure required to be secure" do
            cookie_str = "test_cookie_name=session_value_here; path=/; Expires=Tue, 11 Aug 2020 07:17:12 GMT; Secure"
            rules = {"Secure" => true}
            parsed_cookie = NaiveCookie.new(cookie_str)
            validation_results = parsed_cookie.validate!(rules)
            expect(validation_results).to eq(nil)
        end

    end



end