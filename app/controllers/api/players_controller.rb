# class Api::PlayersController < ApplicationController
#   def show
#     @player = current_user.as_json
#     avatar = current_user.avatar

#     if avatar.present?
#       @player['avatar'] = encode_base64(avatar)
#     end
#     # else
#     #   @player['avatar'] = URI('/assets/images/nurse.png')
#     # end

#     render json: @player
#   end

#   private
#   def encode_base64(image_file)
#     avatar = Base64.encode64(image_file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
#     blob = ActiveStorage::Blob.find(image_file[:id]) # Blobを作成
#     "data:#{blob[:content_type]};base64,#{avatar}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
#   end
#   # def find_user
#   #   @user_typing_score = if current_user.reload_user_typing.nil?
#   #                          { hi_score: 0, hi_speed: 0, plays: 0 }
#   #                        else
#   #                          current_user.reload_user_typing
#   #                        end
#   # end

# end
