class DepartmentsController < ApplicationController
    before_action :current_user

    def index
        @departments = Department.all
    end

    def show
        @department = Department.find(params[:id])
    end
end
