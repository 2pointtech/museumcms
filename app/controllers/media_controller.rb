class MediaController < ApplicationController
  layout 'admin'

  def create
    model = eval "#{params[:attachable_type]}.find(#{params[:attachable_id]})"
    created = []
    for file in params[:files]
      medium = Medium.new
      medium.attachable = model
      medium.file = file
      if medium.save
        created.push medium
      end
    end   
            
    @media = model.media
    render :partial => 'medium', :collection => @media
  end

  def update
    @media = Medium.find(params[:id])
    @media.update_attributes(params[:medium])
    render :nothing => true
  end

  def upload
    @func_num = params["CKEditorFuncNum"]
    @ck_editor = params["CKEditor"]
    if params.include?(:upload)
      data = params.delete(:upload) 
      @image = Medium.create({:file => data}) if data.present?
    end
    render :layout => false
  end

  def destroy
    Medium.find(params[:id]).destroy
    render :nothing => true 
  end 
end
