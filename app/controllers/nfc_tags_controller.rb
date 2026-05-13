class NfcTagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_nfc_tag, only: [:edit, :update, :destroy]

  def index
    @nfc_tags = current_tenant.nfc_tags
  end

  def new
    @nfc_tag = current_tenant.nfc_tags.build
  end

  def create
    @nfc_tag = current_tenant.nfc_tags.build(nfc_tag_params)
    if @nfc_tag.save
      redirect_to nfc_tags_path, notice: "タグを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @nfc_tag.update(nfc_tag_params)
      redirect_to nfc_tags_path, notice: "タグを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @nfc_tag.destroy
    redirect_to nfc_tags_path, notice: "タグを削除しました"
  end

  private

  def set_nfc_tag
    @nfc_tag = current_tenant.nfc_tags.find(params[:id])
  end

  def nfc_tag_params
    params.require(:nfc_tag).permit(:tag_id, :label, :event_type, :active)
  end
end
