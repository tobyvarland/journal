class DescriptorsController < ApplicationController

  # Callbacks.
  before_action :set_descriptor, only: [:update, :destroy]

  # POST /descriptors
  def create
    status = {}
    @descriptor = Descriptor.new(descriptor_params)
    if @descriptor.save
      # status[:success] = 'Addition successful.'
    else
      status[:danger] = 'Addition failed. Please try again.'
    end
    redirect_to admin_path, flash: status
  end

  # PATCH/PUT /descriptors/:id
  def update
    status = {}
    if @descriptor.update(descriptor_params)
      # status[:success] = 'Update successful.'
    else
      status[:danger] = 'Update failed. Please try again.'
    end
    redirect_to admin_path, flash: status
  end

  # DELETE /descriptors/:id
  def destroy
    status = {}
    if @descriptor.destroy
      # status[:success] = 'Removal successful.'
    else
      status[:danger] = 'Removal failed. Please try again.'
    end
    redirect_to admin_path, flash: status
  end

private

  # Loads object by ID before action.
  def set_descriptor
    @descriptor = Descriptor.find(params[:id])
  end

  # Define trusted parameters.
  def descriptor_params
    if params.has_key? :hunger_level
      params[:descriptor] = params.delete :hunger_level
    elsif params.has_key? :energy_level
      params[:descriptor] = params.delete :energy_level
    elsif params.has_key? :concentration_level
      params[:descriptor] = params.delete :concentration_level
    elsif params.has_key? :mood
      params[:descriptor] = params.delete :mood
    end
    params.require(:descriptor).permit(:type, :label, :color)
  end

end