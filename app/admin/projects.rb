ActiveAdmin.register Project do
  permit_params :name, :short_desc, :long_desc,
                :amount, :landscape, :thumb, :category_id

  scope :all, default: true
  scope 'Project en draft', :by_on_draft
  scope 'Project en coming', :by_up_coming
  scope 'Project en going', :by_on_going
  scope 'Project en succeed', :by_on_success
  scope 'Project en failed', :by_on_failure

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

  action_item :contrepartie, only: :edit, if: proc{ project.draft? || project.upcoming? } do
    link_to "Add contrepartie", new_admin_contreparty_path(id: params[:id])
  end

  batch_action :going do |ids|
    batch_action_collection.find(ids).each do |project|
      @state = StartOngoing.new.call(project: project)
    end
    if @state.success?
      redirect_to collection_path, alert: "The project have been set to going."
    else
      redirect_to collection_path, alert: "The project is not able to going."
    end
  end

  batch_action :succeed do |ids|
    batch_action_collection.find(ids).each do |project|
      @state = StartSuccess.new.call(project: project)
    end
    if @state.success?
      redirect_to collection_path, alert: "The project have been set to success."
    else
      redirect_to collection_path, alert: "The project is not able to be succeed."
    end
  end

  batch_action :failed do |ids|
    batch_action_collection.find(ids).each do |project|
      @state = StartFailure.new.call(project: project)
    end
    if @state.success?
      redirect_to collection_path, alert: "The project have been set to failed."
    else
      redirect_to collection_path, alert: "The project is not able to be failed."
    end
  end

  show do
    attributes_table do
      row :name
      row :short_desc
      row :long_desc
      row :amount
      row :category
      row :created_at
      row :landscape do |project|
        unless project.landscape.blank?
          image_tag(project.landscape.url)
        end
      end
      row :thumb do |project|
        unless project.thumb.blank?
          image_tag(project.thumb.url)
        end
      end
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
        unless project.contributions.empty?
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

  controller do
    def create
      project = Project.new(project_params)
      transaction = CreateProject.new.call(project: project)
      if transaction.success?
        StartUpcoming.new.call(project: project)
        redirect_to admin_project_path(project.id)
      else
        @project = transaction.failure[:resource]
        render :new
      end
    end

    def update
      super
      project = Project.find(params[:id])
      StartUpcoming.new.call(project: project)
    end

    private

    def project_params
      params.require(:project).permit(:name, :short_desc, :long_desc,
                                      :amount, :landscape, :thumb,
                                      :category_id)
    end
  end
end
