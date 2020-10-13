class MagicCard < ApplicationRecord
    def self.default_order
        order('id ASC')
    end
end
