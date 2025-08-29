#!/usr/bin/env ruby

require 'fileutils'
require 'date'

def create_post
  puts "=== Jekyll Post Generator ==="
  
  # 카테고리 선택
  categories = ['journal', 'book', 'movie']
  puts "\n카테고리를 선택하세요:"
  categories.each_with_index { |cat, i| puts "#{i+1}. #{cat}" }
  
  category_index = gets.chomp.to_i - 1
  category = categories[category_index] || 'journal'
  
  # 제목 입력 (필수)
  title = ""
  while title.strip.empty?
    puts "\n게시물 제목을 입력하세요 (필수):"
    title = gets.chomp.strip
    if title.empty?
      puts "❌ 제목은 필수입니다. 다시 입력해주세요."
    end
  end
  
  # 날짜 (기본값: 오늘)
  puts "\n날짜를 입력하세요 (YYYY-MM-DD, 엔터시 오늘):"
  date_input = gets.chomp.strip
  date = date_input.empty? ? Date.today : Date.parse(date_input)
  
  # 파일명 생성 (한글 지원)
  safe_title = title.strip
  
  # 한글 파일명 처리
  if safe_title.match?(/[가-힣]/)
    # 한글 제목을 그대로 사용하되 특수문자만 제거
    safe_title = safe_title.gsub(/[^\w\s가-힣-]/, '')  # 한글, 영문, 숫자, 공백, 하이픈만 허용
                           .gsub(/\s+/, '-')            # 공백을 하이픈으로 변경
                           .gsub(/-+/, '-')             # 연속된 하이픈을 하나로
                           .gsub(/^-|-$/, '')           # 앞뒤 하이픈 제거
  else
    # 영문인 경우 정리
    safe_title = safe_title.downcase
                           .gsub(/[^\w\s-]/, '')
                           .gsub(/\s+/, '-')
                           .gsub(/-+/, '-')
                           .gsub(/^-|-$/, '')
  end
  
  # 파일명이 비어있거나 너무 짧으면 기본값 사용
  if safe_title.empty? || safe_title.length < 2
    safe_title = "#{category}-post"
  end
  
  filename = "#{date.strftime('%Y-%m-%d')}-#{safe_title}.md"
  filepath = "_posts/#{category}/#{filename}"
  
  # 디렉토리 생성
  FileUtils.mkdir_p("_posts/#{category}")
  
  # 템플릿 파일 읽기
  template_path = "_templates/#{category}_template.md"
  if File.exist?(template_path)
    template_content = File.read(template_path)
    
    # 템플릿 내용을 현재 날짜와 제목으로 치환
    content = template_content.gsub('YYYY-MM-DD', date.strftime('%Y-%m-%d'))
                              .gsub('게시물 제목', title)
                              .gsub('책 제목', title)
                              .gsub('영화 제목', title)
  else
    # 템플릿이 없으면 기본 Front matter 생성
    content = <<~FRONT_MATTER
      ---
      layout: post
      title: "#{title}"
      date: #{date.strftime('%Y-%m-%d')} 10:00:00 +0900
      category: #{category}
      comments: true
      published: true
      # draft: true
      # hidden: true
      # SEO Settings
      description: "#{title}에 대한 게시물입니다"
      keywords: ["#{category}", "#{title}"]
      image: "/assets/images/#{category}/#{date.strftime('%Y-%m-%d')}-#{safe_title}.jpg"
      last_modified_at: #{date.strftime('%Y-%m-%d')}
      ---
      
      여기에 게시물 내용을 작성하세요.
    FRONT_MATTER
  end
  
  # 파일 생성
  File.write(filepath, content)
  
  puts "\n✅ 게시물이 생성되었습니다!"
  puts "📁 파일 위치: #{filepath}"
  puts "📝 카테고리: #{category}"
  puts "📅 날짜: #{date.strftime('%Y-%m-%d')}"
  puts "🔗 편집 명령어: code #{filepath}"
  
  # 에디터로 열기 (선택사항)
  puts "\n에디터로 파일을 열까요? (y/n):"
  if gets.chomp.downcase == 'y'
    system("code #{filepath}")
  end
end

if __FILE__ == $0
  create_post
end
