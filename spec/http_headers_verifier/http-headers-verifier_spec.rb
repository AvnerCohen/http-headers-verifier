require 'rspec'

require './lib/http_headers_validations'

describe HttpHeadersValidations do


    describe "HttpHeadersValidations.assert_expected_header" do
        it "errors when expected header is present with wrong" do
            results = HttpHeadersValidations.assert_expected_header("Path", "/", "\\")
            expect(results).not_to be_empty
        end

        it "doesn't error when expected error is present with the correct header" do
            results = HttpHeadersValidations.assert_expected_header("Path", "/", "/")
            expect(results).to eq(nil)

        end

        it "errors when expected header is present with wrong regexp value" do 
            results = HttpHeadersValidations.assert_expected_header("Moshe", /mar\w{3}tako/, "marAAAtako")
            expect(results).to eq(nil)
        end

        it "doesn't error when expected error is present with the correct regexp header" do
            results = HttpHeadersValidations.assert_expected_header("Moshe", /mar\w{3}tako/, "marAAtako")
            expect(results).not_to be_empty

        end
    end

    describe "HttpHeadersValidations.assert_cookie_value" do
        it "errors when cookie value does not meet rules" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT"
            parsed_cookie = NaiveCookie.new(cookie_str)
            rules = {"test_cookie_name" => {"Secure"=> true}}
            error_text, failed = HttpHeadersValidations.assert_cookie_value(parsed_cookie, rules)
            expect(failed).to eq(true)
        end
        it "errors when cookie config is not specified" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT"
            parsed_cookie = NaiveCookie.new(cookie_str)
            rules = {"non_existingname" => {"Secure"=> true}}
            error_text, failed = HttpHeadersValidations.assert_cookie_value(parsed_cookie, rules)
            expect(failed).to eq(true)
        end
        it "does not error when cookie value meets expectation" do
            cookie_str = "test_cookie_name=session_value_here; path=/; expires=Tue, 11 Aug 2020 07:17:12 GMT; Secure"
            parsed_cookie = NaiveCookie.new(cookie_str)
            rules = {"test_cookie_name" => {"Secure"=> true}}
            error_text, failed = HttpHeadersValidations.assert_cookie_value(parsed_cookie, rules)
            expect(failed).to eq(false)
        end

    end
end


#def self.assert_extra_header(actual_header, actual_value, ignored_headers, avoid_headers)
#def self.assert_cookie_value(parsed_cookie, cookie_rules)