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

  action_item :contrepartie do
    link_to "New contrepartie", new_admin_contreparty_path(project_id: params[:id])
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
      row :id
      row :project_id
    end

    panel "All contreparties" do
      table_for project.contrepartie do
        column "Name" do |contrepartie|
          contrepartie.name
        end
        column "Amount" do |contrepartie|
          contrepartie.amount
        end
        column "Stock state" do |contrepartie|
          contrepartie.stock_state
        end
      end
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
          contribution.contrepartie
        end

        column "Edit contrepartie" do |contribution|
          link_to "edit", edit_admin_contreparty_path(contribution.contrepartie.id)
        end

        column "Delete Contrepartie" do |contribution|
          link_to "delete", admin_contreparty_path(contribution.contrepartie.id), method: :delete, confirm: 'Are you sure to delete this ?'
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
