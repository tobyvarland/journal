class EntriesController < ApplicationController

  # Callbacks.
  before_action :set_entry, only: [:edit, :update, :destroy]

  # POST /entries
  def create
    status = {}
    @entry = Entry.new(entry_params)
    if @entry.save
      # status[:success] = 'Addition successful.'
    else
      status[:danger] = 'Addition failed. Please try again.'
    end
    redirect_to root_path, flash: status
  end

  # GET /entries/:id/edit
  def edit
  end

  # PATCH/PUT /entries/:id
  def update
    if @entry.update(entry_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # DELETE /entries/:id
  def destroy
    status = {}
    if @entry.destroy
      # status[:success] = 'Removal successful.'
    else
      status[:danger] = 'Removal failed. Please try again.'
    end
    redirect_to root_path, flash: status
  end

private

  # Loads object by ID before action.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Define trusted parameters.
  def entry_params
    params.require(:entry).permit(:entry_at,
                                  :meal,
                                  :hunger_level_id,
                                  :energy_level_id,
                                  :concentration_level_id,
                                  :mood_id,
                                  :physiological_reaction,
                                  :notes)
  end

end