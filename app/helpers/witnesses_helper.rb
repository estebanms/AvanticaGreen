module WitnessesHelper
  # routes for witnesses
  def witnesses_path(options = {})
    infraction_witnesses_path(@infraction, options)
  end

  def witnesses_url(options = {})
    witnesses_path(options)
  end

  def witness_path(witness, options = {})
    infraction_witness_path(@infraction, witness, options)
  end

  def witness_url(witness, options = {})
    witness_path(witness, options)
  end

  def edit_witness_path(witness, options = {})
    edit_infraction_witness_path(@infraction, witness, options)
  end

  def new_witness_path(options = {})
    new_infraction_witness_path(@infraction, options)
  end
end
