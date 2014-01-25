require 'open-uri'

class RemindersController < ApplicationController
  # GET /reminders
  # GET /reminders.json
  def index
    @reminders = Reminder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.json
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.json
  def create
    @reminder = Reminder.new(params[:reminder])

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.json
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url }
      format.json { head :no_content }
    end
  end

  #current location
  def current_location 
    latitude = params[:lat]
    longitude = params[:long]

    goog_place_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
    radius = 500

    loc = "#{goog_place_url}?location=#{latitude},#{longitude}&radius=#{radius}&types=grocery_or_supermarket&sensor=false&key=#{GOOGLE_CONFIG['api_key']}"
    puts '===== Place API URI ======'
    puts loc
    puts '=========================='
    url = URI.parse(loc);

    content = open(loc).read

    places = JSON.load(content)

    place_array = []

    places['results'].each do |r|
      hash = {:latitude => r['geometry']['location']['lat'], 
              :longitude => r['geometry']['location']['lng'],
              :name => r['name']}
      place_array.push(hash)
    end

    puts place_array.to_json

    render :json => place_array.to_json
  end



end
