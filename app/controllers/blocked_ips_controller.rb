class BlockedIpsController < ApplicationController
  def index
    @blocked_ips = BlockedIp.all
  end

  def new
    @blocked_ip = BlockedIp.new
  end

  def create
    @blocked_ip = BlockedIp.new(blocked_ips_params)
    if @blocked_ip.save
      redirect_to blocked_ips_path
    else
      render 'new'
    end
  end

  def destroy
    BlockedIp.destroy(params[:id])
    redirect_to blocked_ips_path
  end

  private

  def blocked_ips_params
    params.require(:blocked_ip).permit(:ip, :name, :descrption)
  end
end
