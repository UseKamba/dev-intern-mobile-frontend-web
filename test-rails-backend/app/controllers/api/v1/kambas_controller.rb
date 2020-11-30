class Api::V1::KambasController < ApplicationController
    def index
        @payments = Array.new
        @deposits = Array.new
        @withdrawals = Array.new
        @tvrecharges = Array.new
        filter_response(Services::KambaService.request)
        
        render :index, status: :ok
    rescue Exception => error
        render json: {
            status: 500,
            message: "error => #{error}"
        }, status: :internal_server_error
    end

    private
        def filter_response(json_response)
            json_response.each do |object|
                case object["transaction_type"]
                    when "PAYMENT"
                        @payments << object
                    when "DEPOSIT"
                        @deposits << object
                    when "WITHDRAWAL"
                        @withdrawals << object
                    when "TVRECHARGE"
                        @tvrecharges << object
                end
                # if obejct["transaction_type"] == "PAYMENT"
                #     @payment << obejct
                # elsif obejct["transaction_type"] == "WITHDRAWAL"
                #     @withdrawal << obejct
                # elsif obejct["transaction_type"] == "DEPOSIT"
                #     @deposit << obejct
                # elsif obejct["transaction_type"] == "TVRECHARGE"
                #     @tvrecharge << obejct                         
                # end
            end            
        end
end