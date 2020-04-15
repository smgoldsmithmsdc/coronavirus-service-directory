require 'csv'

task :csv => :environment do
    Service.destroy_all

    response = HTTParty.get(ENV["DATASOURCE"])
    rows = CSV.parse(response.body, headers: true)

    # byebug

    rows.drop(3).each do |row|
        service = Service.new

        service.name = row[0]
        service.description = row[1]

        categories = []
        if row[2] && row[2].downcase.strip == "yes"
            categories.push("food")
        end
        if row[3] && row[3].downcase.strip == "yes"
            categories.push("meds")
        end
        if row[4] && row[4].downcase.strip == "yes"
            categories.push("social")
        end
        if row[5] && row[5].downcase.strip == "yes"
            categories.push("house")
        end
        if row[6] && row[6].downcase.strip == "yes"
            categories.push("pets")
        end
        if row[7] && row[7].downcase.strip == "yes"
            categories.push("care")
        end

        service.category = categories

        service.url = row[10]
        service.phone = row[11]
        service.email = row[12]
        service.postcode = row[13]
        service.recommended = row[15]
        service.key_point_1 = row[17]
        service.key_point_2 = row[18]
        service.key_point_3 = row[19]
        service.how_to_contact = row[20]

        service.save
    end
end