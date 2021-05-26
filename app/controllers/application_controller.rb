class ApplicationController < ActionController::API
    def format_error(path, message)
        { message: [{ path: path, message: message }] }
      end
end
