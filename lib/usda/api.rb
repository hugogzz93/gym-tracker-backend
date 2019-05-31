require 'HTTParty'
require 'singleton'

class Unit
  def initializer(value, unit)
    @value = value
    @unit = unit
  end

  def to_grams
    case @unit
    when 'µg'
      @value * 1000000
    when 'mg'
      @value * 1000
    end
  end

  def to_cal
    case @unit
    when 'kcal'
      @value
    end
  end

end

module USDA
  class Api
    include Singleton
    STANDARD_SIZE = 100

    @api_key = Rails.application.credentials.usda_db_api_key
    @base_url =  'https://api.nal.usda.gov/ndb/V2/reports'
    # '?ndbno=01009&ndbno=01009&ndbno=45202763&ndbno=35193&type=b&format=json&api_key=DEMO_KEY'

    class << self
      def single_report(intake)
        url = build_req_url(ids: [intake.ndbid])
        res = fetch(url)
        res['foods'].first['food']
      end

      def report(intakes)
        url = build_req_url(ids: intakes.map(&:ndbid).uniq)
        res = fetch(url)

        foods = res['foods'].map do |pack|
          food = pack['food'].tap do |food|
            food['grams'] = intakes.where(ndbid: food['desc']['ndbno']).sum(:grams)
          end
        end

        { foods: foods, total: sum(foods) }
      end

      def fetch(url)
        response = HTTParty.get(url)
        res = JSON.parse(response.body)
        throw 'Error' if(res['error']) 
        res
      end

      def sum(foods)
        totals = {}
        foods.each do |food|
          food['nutrients'].each do |n|
            sum = totals[n['nutrient_id']]
            # if(n['nutrient_id'] == '255') 
            #   debugger
            # end
            if sum
              throw 'invalid unit' if sum['unit'] != n['unit']
              sum['value'] += n['value'].to_f * food['grams'].to_f / STANDARD_SIZE
            else
              sum = n.tap {|x| x['value'] = x['value'].to_f * food['grams'].to_f / STANDARD_SIZE }
            end
            totals[n['nutrient_id']] = sum
          end
        end
        totals.keys.map {|x| totals[x] }
      end

      private
      def build_req_url(ids:, type: 'b')
        ndbnos = ids.each_with_index.map do |id, i|
          i == 0 ? "?ndbno=#{id}" : "&ndbno=#{id}"
        end

        "#{@base_url}/#{ndbnos.join('')}&type=#{type}&format=json&api_key=#{@api_key}"
      end
    end
  end
end
