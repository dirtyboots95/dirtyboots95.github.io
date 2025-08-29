# Jekyll Blog Management

.PHONY: serve build clean new-post new-journal new-book new-movie

# 개발 서버 실행
serve:
	bundle exec jekyll serve --livereload

# 사이트 빌드
build:
	bundle exec jekyll build

# 빌드 파일 정리
clean:
	bundle exec jekyll clean

# 새 게시물 생성 (대화형)
new-post:
	ruby create_post.rb

# 새 journal 게시물 생성
new-journal:
	@read -p "제목을 입력하세요: " title; \
	date=$$(date +%Y-%m-%d); \
	filename="_posts/journal/$$date-$${title// /-}.md"; \
	mkdir -p _posts/journal; \
	echo "---" > $$filename; \
	echo "layout: post" >> $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	echo "date: $$date 10:00:00 +0900" >> $$filename; \
	echo "category: journal" >> $$filename; \
	echo "comments: true" >> $$filename; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "게시물 내용을 여기에 작성하세요." >> $$filename; \
	echo "✅ Journal 게시물이 생성되었습니다: $$filename"

# 새 book 게시물 생성
new-book:
	@read -p "제목을 입력하세요: " title; \
	date=$$(date +%Y-%m-%d); \
	filename="_posts/book/$$date-$${title// /-}.md"; \
	mkdir -p _posts/book; \
	echo "---" > $$filename; \
	echo "layout: post" >> $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	echo "date: $$date 10:00:00 +0900" >> $$filename; \
	echo "category: book" >> $$filename; \
	echo "comments: true" >> $$filename; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "책 리뷰 내용을 여기에 작성하세요." >> $$filename; \
	echo "✅ Book 게시물이 생성되었습니다: $$filename"

# 새 movie 게시물 생성
new-movie:
	@read -p "제목을 입력하세요: " title; \
	date=$$(date +%Y-%m-%d); \
	filename="_posts/movie/$$date-$${title// /-}.md"; \
	mkdir -p _posts/movie; \
	echo "---" > $$filename; \
	echo "layout: post" >> $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	echo "date: $$date 10:00:00 +0900" >> $$filename; \
	echo "category: movie" >> $$filename; \
	echo "comments: true" >> $$filename; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "영화 리뷰 내용을 여기에 작성하세요." >> $$filename; \
	echo "✅ Movie 게시물이 생성되었습니다: $$filename"
