class ShipmentFee < ActiveHash::Base
  self.data = [
      {id: 1, name: '送料込（出品者負担）'},
      {id: 2, name: '送料別（購入者負担）'}
  ]
end
