module DateHelper
    def formatIsoDate(date)
        return Time.parse(date).strftime("%Y-%m-%d %H:%M:%S")  
    end
end
