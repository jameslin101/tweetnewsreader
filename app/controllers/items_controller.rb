class ItemsController < ApplicationController
  # GET /widgets
  # GET /widgets.json
  def index
    @new_item = Item.new
    @items = Item.all
    @incomplete_items = @items.select{|i| i.completed_flag == false}
    @complete_items = @items.select{|i| i.completed_flag == true}
    @items_to_be_updated

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @widgets }
    end
  end

  def create
    Item.create(params[:item])
    redirect_to action: "index"
  end

  def update_all_items
    params.inspect

    redirect_to action: "index"

  end
end
