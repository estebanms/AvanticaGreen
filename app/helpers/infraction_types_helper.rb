module InfractionTypesHelper
  def infraction_types_select(object = :infraction, field_name = :infraction_type_id, options = {})
    collection_select(object, field_name, InfractionType.all, :id, :name, options)
  end
end
