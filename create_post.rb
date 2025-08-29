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
  
  # 제목 입력
  puts "\n게시물 제목을 입력하세요:"
  title = gets.chomp.strip
  
  # 날짜 (기본값: 오늘)
  puts "\n날짜를 입력하세요 (YYYY-MM-DD, 엔터시 오늘):"
  date_input = gets.chomp.strip
  date = date_input.empty? ? Date.today : Date.parse(date_input)
  
  # 파일명 생성
  safe_title = title.downcase.gsub(/[^a-z0-9\s-]/, '').gsub(/\s+/, '-')
  filename = "#{date.strftime('%Y-%m-%d')}-#{safe_title}.md"
  filepath = "_posts/#{category}/#{filename}"
  
  # 디렉토리 생성
  FileUtils.mkdir_p("_posts/#{category}")
  
  # Front matter 생성
  front_matter = <<~FRONT_MATTER
    ---
    layout: post
    title: "#{title}"
    date: #{date.strftime('%Y-%m-%d')} 10:00:00 +0900
    category: #{category}
    comments: true
    ---
    
  FRONT_MATTER
  
  # 파일 생성
  File.write(filepath, front_matter)
  
  puts "\n✅ 게시물이 생성되었습니다!"
  puts "📁 파일 위치: #{filepath}"
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
