class MagicCard < ApplicationRecord
    def self.default_order
        order('id ASC')
    end

    def self.alphabetical
        order(:name)
    end
    # def to_param
    #     "#{id}-#{name}"
    # end
end
