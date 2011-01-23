require 'net/http'
require 'cgi'

def http_get(domain,path,params)
    return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))) if not params.nil?
    return Net::HTTP.get(domain, path)
end

params = {:q => "ruby", :max => 50}
#print http_get("www.google.com", "/search", params)
page = http_get("www.google.com", "/search", params)

