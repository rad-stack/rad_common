module Api
  class DivisionsController < Api::BasicAppController
    before_action :set_division, only: :show

    def show
      render json: { name: @division.name }, status: :ok
    end

    private

      def set_division
        @division = Division.find(params[:id])
      end
  end
end
