ActiveAdmin.register Project do
  permit_params :name, :short_desc, :long_desc,
                :amount, :landscape, :thumb, :category_id

  index do
    selectable_column
    id_column
    column :name
    column :short_desc
    column :long_desc
    column :amount
    column :landscape
    column :thumb
    column :category
    column :created_at
    actions
  end

    filter :name
    filter :short_desc
    filter :long_desc
    filter :amount
    filter :landscape
    filter :thumb
    filter :category
    filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :short_desc
      f.input :long_desc
      f.input :amount
      f.input :landscape, as: :file
      f.input :thumb, as: :file
      f.input :category
    end
    f.actions
  end

  show do
    attributes_table do
      row :landscape do |project|
        image_tag(project.landscape.url)
      end
      row :thumb do |project|
        image_tag(project.thumb.url)
      end
      row :name
      row :short_desc
      row :long_desc
      row :amount
      row :category
      row :created_at
    end
    
    panel "Contribution details" do
      table_for project.contributions do
        column "Names" do |contribution|
          name = User.find(contribution.user_id).full_name
          link_to "#{name}", admin_user_path(contribution.user_id)
        end

        column "Contribution" do |contribution|
          contribution.amount
        end

        column "Contrepartie" do |contribution|
          Contrepartie.find_by(contribution: contribution.id)
        end

        column "Date of creation" do |contribution|
          contribution.created_at
        end
      end
    end

    panel "Contribution stats" do
      attributes_table_for project do
        row 'Contribution total' do
          project.totalize_contributions
        end
        row 'Lower Contribution' do
          project.lower_contribution
        end
        row 'Higher Contribution' do
          project.higher_contribution
        end
        row 'Percentage of completion' do
          project.percentage_of_completion
        end
      end
    end
  end
end
