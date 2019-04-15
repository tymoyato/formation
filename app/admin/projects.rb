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
    attributes_table do
      row 'Names' do |u|
        u.contributions.map do |project|
          User.find(project.user_id).first_name
        end
        .join(" ,").html_safe
      end
      row 'Contributions' do |u|
        u.contributions.map do |project|
          project.amount
        end
        .join(" ,").html_safe
      end
      row 'Contreparties' do |u|
        u.contributions.map do |project|
          Contrepartie.find_by(contribution: project.id).name
        end
        .join(" ,").html_safe
      end
      row 'Date of creation' do |u|
        u.contributions.map do |project|
          project.created_at
        end
        .join(" ,").html_safe
      end
      # row 'Amounts' do |u|
      #   u.contributions.map do |pj|
      #     pj.amount
      #   end
      #   .join("<br />").html_safe
      # end
      # row 'Contreparties' do |u|
      #   u.contributions.map do |pj|
      #     pj.amount
      #   end
      #   .join("<br />").html_safe
      # end
      # row 'Dates' do |u|
      #   u.contributions.map do |pj|
      #     pj.amount
      #   end
      #   .join("<br />").html_safe
      # end
    end
  end
end
