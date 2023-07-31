class ApplicationController < ActionController::Base
  helper_method :default_meta_tags

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストとしてログインしました。'
  end

  def default_meta_tags
    {
      site: 'Debu Prison',
      title: 'Debu Prison ダイエットのための食事や運動管理アプリ',
      description: 'ダイエットのための食事や運動記録の管理アプリ。一日の消費カロリー自動計算や、食べたものの記録・管理ができます。掲示板でみんなと共有しよう。',
      keywords: 'ダイエット, カロリー',
      og: {
        title: :title,
        type: 'website',
        url: request.original_url,
        image: 'logo.png',
        site_name: :site,
        description: :description
      }
    }
  end

end
