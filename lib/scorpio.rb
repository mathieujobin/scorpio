require "scorpio/version"

module Scorpio
  proc { |v| define_singleton_method(:error_classes_by_status) { v } }.call({})
  class Error < StandardError; end
  class HTTPError < Error
    define_singleton_method(:status) { |status| Scorpio.error_classes_by_status[status] = self }
    attr_accessor :response
  end
  class ClientError < HTTPError; end
  class ServerError < HTTPError; end

  class BadRequest400Error < ClientError;                    status(400); end
  class Unauthorized401Error < ClientError;                  status(401); end
  class PaymentRequired402Error < ClientError;               status(402); end
  class Forbidden403Error < ClientError;                     status(403); end
  class NotFound404Error < ClientError;                      status(404); end
  class MethodNotAllowed405Error < ClientError;              status(405); end
  class NotAcceptable406Error < ClientError;                 status(406); end
  class ProxyAuthenticationRequired407Error < ClientError;   status(407); end
  class RequestTimeout408Error < ClientError;                status(408); end
  class Conflict409Error < ClientError;                      status(409); end
  class Gone410Error < ClientError;                          status(410); end
  class LengthRequired411Error < ClientError;                status(411); end
  class PreconditionFailed412Error < ClientError;            status(412); end
  class PayloadTooLarge413Error < ClientError;               status(413); end
  class URITooLong414Error < ClientError;                    status(414); end
  class UnsupportedMediaType415Error < ClientError;          status(415); end
  class RangeNotSatisfiable416Error < ClientError;           status(416); end
  class ExpectationFailed417Error < ClientError;             status(417); end
  class ImaTeapot418Error < ClientError;                     status(418); end
  class MisdirectedRequest421Error < ClientError;            status(421); end
  class UnprocessableEntity422Error < ClientError;           status(422); end
  class Locked423Error < ClientError;                        status(423); end
  class FailedDependency424Error < ClientError;              status(424); end
  class UpgradeRequired426Error < ClientError;               status(426); end
  class PreconditionRequired428Error < ClientError;          status(428); end
  class TooManyRequests429Error < ClientError;               status(429); end
  class RequestHeaderFieldsTooLarge431Error < ClientError;   status(431); end
  class UnavailableForLegalReasons451Error < ClientError;    status(451); end

  class InternalServerError500Error < ServerError;           status(500); end
  class NotImplemented501Error < ServerError;                status(501); end
  class BadGateway502Error < ServerError;                    status(502); end
  class ServiceUnavailable503Error < ServerError;            status(503); end
  class GatewayTimeout504Error < ServerError;                status(504); end
  class HTTPVersionNotSupported505Error < ServerError;       status(505); end
  class VariantAlsoNegotiates506Error < ServerError;         status(506); end
  class InsufficientStorage507Error < ServerError;           status(507); end
  class LoopDetected508Error < ServerError;                  status(508); end
  class NotExtended510Error < ServerError;                   status(510); end
  class NetworkAuthenticationRequired511Error < ServerError; status(511); end
  error_classes_by_status.freeze

  autoload :Model, 'scorpio/model'

  class << self
    def stringify_symbol_keys(hash)
      unless hash.is_a?(Hash)
        raise ArgumentError, "expected argument to be a Hash; got #{hash.class}: #{hash.inspect}"
      end
      hash.map { |k,v| {k.is_a?(Symbol) ? k.to_s : k => v} }.inject({}, &:update)
    end
  end
end
