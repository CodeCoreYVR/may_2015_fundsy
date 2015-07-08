ActiveAdmin.register Campaign do

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :goal
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :description
      f.input :goal
      f.input :due_date
    end
    f.actions
  end

permit_params do
  [:title, :description,
  :due_date, :goal, {reward_levels_attributes: [:title, :description,
                                                :amount, :id, :_destroy]}]
end


end
