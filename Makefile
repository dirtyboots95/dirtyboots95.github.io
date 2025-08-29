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
	@read -p "브랜치 이름을 입력하세요 (엔터로 건너뛰기): " branch_name; \
	if [ -n "$$branch_name" ]; then \
		git checkout -b $$branch_name; \
		echo "✅ 브랜치가 생성되었습니다: $$branch_name"; \
	fi; \
	ruby create_post.rb; \
	if [ -n "$$branch_name" ]; then \
		echo "✅ 게시물이 생성되었습니다. 브랜치를 푸시하려면 'make push-feature'를 실행하세요."; \
	else \
		echo "✅ 게시물이 생성되었습니다."; \
	fi

# 새 journal 게시물 생성
new-journal:
	@read -p "브랜치 이름을 입력하세요 (엔터로 건너뛰기): " branch_name; \
	if [ -n "$$branch_name" ]; then \
		git checkout -b $$branch_name; \
		echo "✅ 브랜치가 생성되었습니다: $$branch_name"; \
	fi; \
	read -p "제목을 입력하세요: " title; \
	date=$$(date +%Y-%m-%d); \
	safe_title=$$(echo "$$title" | sed 's/[^가-힣a-zA-Z0-9\s-]//g' | sed 's/\s\+/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$$//'); \
	filename="_posts/journal/$$date-$$safe_title.md"; \
	mkdir -p _posts/journal; \
	if [ -f "_templates/journal_template.md" ]; then \
		cp "_templates/journal_template.md" $$filename; \
		sed -i '' "s/YYYY-MM-DD/$$date/g" $$filename; \
		sed -i '' "s/게시물 제목/$$title/g" $$filename; \
	else \
		echo "---" > $$filename; \
		echo "layout: post" >> $$filename; \
		echo "title: \"$$title\"" >> $$filename; \
		echo "date: $$date 10:00:00 +0900" >> $$filename; \
		echo "category: journal" >> $$filename; \
		echo "comments: true" >> $$filename; \
		echo "---" >> $$filename; \
		echo "" >> $$filename; \
		echo "게시물 내용을 여기에 작성하세요." >> $$filename; \
	fi; \
	git add $$filename; \
	git commit -m "Add journal post: $$title"; \
	if [ -n "$$branch_name" ]; then \
		git push origin $$branch_name; \
		echo "✅ Journal 게시물이 생성되고 브랜치가 푸시되었습니다: $$filename (브랜치: $$branch_name)"; \
	else \
		echo "✅ Journal 게시물이 생성되었습니다: $$filename (현재 브랜치에 커밋됨)"; \
	fi

# 새 book 게시물 생성
new-book:
	@read -p "브랜치 이름을 입력하세요 (엔터로 건너뛰기): " branch_name; \
	if [ -n "$$branch_name" ]; then \
		git checkout -b $$branch_name; \
		echo "✅ 브랜치가 생성되었습니다: $$branch_name"; \
	fi; \
	read -p "제목을 입력하세요: " title; \
	date=$$(date +%Y-%m-%d); \
	safe_title=$$(echo "$$title" | sed 's/[^가-힣a-zA-Z0-9\s-]//g' | sed 's/\s\+/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$$//'); \
	filename="_posts/book/$$date-$$safe_title.md"; \
	mkdir -p _posts/book; \
	if [ -f "_templates/book_template.md" ]; then \
		cp "_templates/book_template.md" $$filename; \
		sed -i '' "s/YYYY-MM-DD/$$date/g" $$filename; \
		sed -i '' "s/책 제목/$$title/g" $$filename; \
	else \
		echo "---" > $$filename; \
		echo "layout: post" >> $$filename; \
		echo "title: \"$$title\"" >> $$filename; \
		echo "date: $$date 10:00:00 +0900" >> $$filename; \
		echo "category: book" >> $$filename; \
		echo "comments: true" >> $$filename; \
		echo "---" >> $$filename; \
		echo "" >> $$filename; \
		echo "책 리뷰 내용을 여기에 작성하세요." >> $$filename; \
	fi; \
	git add $$filename; \
	git commit -m "Add book review: $$title"; \
	if [ -n "$$branch_name" ]; then \
		git push origin $$branch_name; \
		echo "✅ Book 게시물이 생성되고 브랜치가 푸시되었습니다: $$filename (브랜치: $$branch_name)"; \
	else \
		echo "✅ Book 게시물이 생성되었습니다: $$filename (현재 브랜치에 커밋됨)"; \
	fi

# 새 movie 게시물 생성
new-movie:
	@read -p "브랜치 이름을 입력하세요 (엔터로 건너뛰기): " branch_name; \
	if [ -n "$$branch_name" ]; then \
		git checkout -b $$branch_name; \
		echo "✅ 브랜치가 생성되었습니다: $$branch_name"; \
	fi; \
	read -p "제목을 입력하세요: " title; \
	date=$$(date +%Y-%m-%d); \
	safe_title=$$(echo "$$title" | sed 's/[^가-힣a-zA-Z0-9\s-]//g' | sed 's/\s\+/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$$//'); \
	filename="_posts/movie/$$date-$$safe_title.md"; \
	mkdir -p _posts/movie; \
	if [ -f "_templates/movie_template.md" ]; then \
		cp "_templates/movie_template.md" $$filename; \
		sed -i '' "s/YYYY-MM-DD/$$date/g" $$filename; \
		sed -i '' "s/영화 제목/$$title/g" $$filename; \
	else \
		echo "---" > $$filename; \
		echo "layout: post" >> $$filename; \
		echo "title: \"$$title\"" >> $$filename; \
		echo "date: $$date 10:00:00 +0900" >> $$filename; \
		echo "category: movie" >> $$filename; \
		echo "comments: true" >> $$filename; \
		echo "---" >> $$filename; \
		echo "" >> $$filename; \
		echo "영화 리뷰 내용을 여기에 작성하세요." >> $$filename; \
	fi; \
	git add $$filename; \
	git commit -m "Add movie review: $$title"; \
	if [ -n "$$branch_name" ]; then \
		git push origin $$branch_name; \
		echo "✅ Movie 게시물이 생성되고 브랜치가 푸시되었습니다: $$filename (브랜치: $$branch_name)"; \
	else \
		echo "✅ Movie 게시물이 생성되었습니다: $$filename (현재 브랜치에 커밋됨)"; \
	fi

# 브랜치 보호를 위한 명령어들
.PHONY: new-branch push-post create-pr protect-main

# 새로운 기능 브랜치 생성
new-branch:
	@read -p "브랜치 이름을 입력하세요 (예: post/new-post): " branch_name; \
	git checkout -b $$branch_name; \
	echo "✅ 새로운 브랜치가 생성되었습니다: $$branch_name"

# 현재 브랜치를 커밋하고 원격에 푸시
push-post:
	@current_branch=$$(git branch --show-current); \
	read -p "커밋 메시지를 입력하세요: " commit_message; \
	git add .; \
	git commit -m "$$commit_message"; \
	echo "🔄 원격 브랜치와 동기화 중..."; \
	git pull origin $$current_branch --rebase || (echo "❌ 동기화 실패. 충돌을 해결한 후 다시 시도하세요."; exit 1); \
	echo "🚀 원격에 푸시 중..."; \
	git push origin $$current_branch || (echo "❌ 푸시 실패. 다시 시도하세요."; exit 1); \
	echo "✅ 브랜치가 커밋되고 원격에 푸시되었습니다: $$current_branch"

# Pull Request 생성 (GitHub CLI 필요)
create-pr:
	@read -p "PR 제목을 입력하세요: " pr_title; \
	read -p "PR 설명을 입력하세요: " pr_description; \
	current_branch=$$(git branch --show-current); \
	git pull origin $$current_branch --rebase; \
	git push origin $$current_branch; \
	gh pr create --title "$$pr_title" --body "$$pr_description" --base main; \
	echo "✅ Pull Request가 생성되었습니다"

# Pull Request 자동 승인 및 머지 (GitHub CLI 필요)
approve-pr:
	@read -p "PR 번호를 입력하세요: " pr_number; \
	gh pr review $$pr_number --approve; \
	gh pr merge $$pr_number --merge; \
	echo "✅ Pull Request가 승인되고 머지되었습니다: #$$pr_number"

# main 브랜치 보호 설정 (로컬)
protect-main:
	@echo "🔒 main 브랜치 보호 설정을 시작합니다..."; \
	git config core.hooksPath .git/hooks; \
	echo '#!/bin/sh' > .git/hooks/pre-push; \
	echo 'current_branch=$$(git symbolic-ref HEAD | sed -e "s/^refs\/heads\///")' >> .git/hooks/pre-push; \
	echo 'if [ "$$current_branch" = "main" ]; then' >> .git/hooks/pre-push; \
	echo '  echo "❌ main 브랜치에 직접 push할 수 없습니다!"' >> .git/hooks/pre-push; \
	echo '  echo "💡 대신 feature 브랜치를 생성하여 작업하세요:"' >> .git/hooks/pre-push; \
	echo '  echo "   make new-branch"' >> .git/hooks/pre-push; \
	echo '  exit 1' >> .git/hooks/pre-push; \
	echo 'fi' >> .git/hooks/pre-push; \
	chmod +x .git/hooks/pre-push; \
	echo "✅ main 브랜치 보호가 설정되었습니다!"; \
	echo "💡 이제 main 브랜치에 직접 push할 수 없습니다."
