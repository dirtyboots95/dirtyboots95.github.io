# Jekyll Blog Management

.PHONY: serve build clean new-post new-draft

# 개발 서버 실행
serve:
	bundle exec jekyll serve --livereload

# Production 환경으로 로컬 실행
serve-prod:
	JEKYLL_ENV=production bundle exec jekyll serve

# 사이트 빌드
build:
	bundle exec jekyll build

# 빌드 파일 정리
clean:
	bundle exec jekyll clean

# 새 게시물 생성 (루트 _posts/에 생성)
new-post:
	@read -p "브랜치 이름을 입력하세요 (엔터로 건너뛰기): " branch_name; \
	if [ -n "$$branch_name" ]; then \
		git checkout -b $$branch_name; \
		echo "✅ 브랜치가 생성되었습니다: $$branch_name"; \
	fi; \
	read -p "제목을 입력하세요 (기본값: untitled): " title; \
	read -p "카테고리(선택, 기본값 journal): " category; \
	read -p "태그(쉼표로 구분, 선택): " tags; \
	if [ -z "$$title" ]; then title=untitled; fi; \
	if [ -z "$$category" ]; then category=journal; fi; \
	date=$$(date +%Y-%m-%d); \
	safe_title=$$(echo "$$title" | sed 's/[^가-힣a-zA-Z0-9\s-]//g' | sed 's/\s\+/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$$//' | sed 's/--/-/g'); \
	filename="_posts/$$date-$$safe_title.md"; \
	echo "---" > $$filename; \
	echo "layout: post" >> $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	echo "date: $$date 10:00:00 +0900" >> $$filename; \
	echo "category: $$category" >> $$filename; \
	if [ -n "$$tags" ]; then echo "tags: [$$tags]" >> $$filename; fi; \
	echo "comments: true" >> $$filename; \
	echo "published: true" >> $$filename; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "게시물 내용을 여기에 작성하세요." >> $$filename; \
	echo "✅ 게시물이 생성되었습니다: $$filename"; \
	git add $$filename; \
	git commit -S -m "Add post: $$title" >/dev/null 2>&1 || true; \
	if [ -n "$$branch_name" ]; then \
		echo "✅ 게시물이 생성되었습니다. 브랜치를 푸시하려면 'make push-post'를 실행하세요."; \
	else \
		echo "✅ 게시물이 생성되었습니다."; \
	fi

# 새 초안 생성 (_drafts/에 생성)
new-draft:
	@read -p "브랜치 이름을 입력하세요 (엔터로 건너뛰기): " branch_name; \
	if [ -n "$$branch_name" ]; then \
		git checkout -b $$branch_name; \
		echo "✅ 브랜치가 생성되었습니다: $$branch_name"; \
	fi; \
	read -p "제목을 입력하세요 (기본값: untitled): " title; \
	read -p "카테고리(선택): " category; \
	read -p "태그(쉼표로 구분, 선택): " tags; \
	if [ -z "$$title" ]; then title=untitled; fi; \
	safe_title=$$(echo "$$title" | sed 's/[^가-힣a-zA-Z0-9\s-]//g' | sed 's/\s\+/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$$//' | sed 's/--/-/g'); \
	filename="_drafts/$$safe_title.md"; \
	echo "---" > $$filename; \
	echo "layout: post" >> $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	if [ -n "$$category" ]; then echo "category: $$category" >> $$filename; fi; \
	if [ -n "$$tags" ]; then echo "tags: [$$tags]" >> $$filename; fi; \
	echo "comments: true" >> $$filename; \
	echo "published: false" >> $$filename; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "초안 내용을 여기에 작성하세요." >> $$filename; \
	echo "✅ 초안이 생성되었습니다: $$filename"; \
	git add $$filename; \
	git commit -S -m "Add draft: $$title" >/dev/null 2>&1 || true; \
	if [ -n "$$branch_name" ]; then \
		echo "✅ 초안이 생성되었습니다. 브랜치를 푸시하려면 'make push-post'를 실행하세요."; \
	else \
		echo "✅ 초안이 생성되었습니다."; \
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
	git commit -S -m "$$commit_message" || true; \
	echo "🔄 원격 브랜치 확인 중..."; \
	if git ls-remote --heads origin $$current_branch | grep -q $$current_branch; then \
		echo "📥 원격 브랜치와 동기화 중..."; \
		git pull origin $$current_branch --rebase || (echo "❌ 동기화 실패. 충돌을 해결한 후 다시 시도하세요."; exit 1); \
	else \
		echo "🆕 새로운 브랜치입니다. 동기화를 건너뜁니다."; \
	fi; \
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

# PR 생성 후 자동 머지 (GitHub CLI 필요)
create-and-merge-pr:
	@read -p "PR 제목을 입력하세요: " pr_title; \
	read -p "PR 설명을 입력하세요: " pr_description; \
	current_branch=$$(git branch --show-current); \
	git pull origin $$current_branch --rebase || (echo "❌ 동기화 실패. 충돌을 해결한 후 다시 시도하세요."; exit 1); \
	git push origin $$current_branch || (echo "❌ 푸시 실패. 다시 시도하세요."; exit 1); \
	pr_url=$$(gh pr create --title "$$pr_title" --body "$$pr_description" --base main); \
	echo "✅ Pull Request가 생성되었습니다: $$pr_url"; \
	pr_number=$$(echo $$pr_url | sed 's/.*\/pull\///'); \
	gh pr merge $$pr_number --merge; \
	echo "✅ Pull Request가 머지되었습니다: #$$pr_number"

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

# 이미지 파일명 대소문자 정리
fix-image-names:
	@echo "🖼️ 이미지 파일명을 소문자로 정리합니다..."; \
	find assets/images -name "*.JPG" -exec sh -c 'mv "$$1" "$${1%.JPG}.jpg"' _ {} \; 2>/dev/null || true; \
	find assets/images -name "*.PNG" -exec sh -c 'mv "$$1" "$${1%.PNG}.png"' _ {} \; 2>/dev/null || true; \
	find assets/images -name "*.JPEG" -exec sh -c 'mv "$$1" "$${1%.JPEG}.jpeg"' _ {} \; 2>/dev/null || true; \
	echo "✅ 이미지 파일명이 소문자로 정리되었습니다."

# 이미지 파일명 확인
check-image-names:
	@echo "🔍 대문자 확장자를 가진 이미지 파일을 찾습니다..."; \
	find assets/images -name "*.JPG" -o -name "*.PNG" -o -name "*.JPEG" | head -10; \
	if [ $$(( $$(find assets/images -name "*.JPG" -o -name "*.PNG" -o -name "*.JPEG" | wc -l) )) -eq 0 ]; then \
		echo "✅ 모든 이미지 파일이 소문자 확장자를 사용합니다."; \
	else \
		echo "⚠️ 위 파일들의 확장자를 소문자로 변경하려면 'make fix-image-names'를 실행하세요."; \
	fi

# Node.js 의존성 설치
.PHONY: install-deps setup-ga4 test-ga4

# GA4 환경 변수 설정
setup-ga4:
	@echo "🔧 Google Analytics 4 환경 변수 설정 중..."; \
	if [ -f ".secrets/ga4-service-account.json" ]; then \
		export GOOGLE_APPLICATION_CREDENTIALS="$$((pwd))/.secrets/ga4-service-account.json"; \
		export GA4_PROPERTY_ID="503083435"; \
		export GA4_MEASUREMENT_ID="G-H9LCES4944"; \
		export JEKYLL_ENV="production"; \
		echo "✅ 환경 변수 설정 완료!"; \
		echo "💡 이제 'make test-ga4'로 API를 테스트할 수 있습니다."; \
	else \
		echo "❌ .secrets/ga4-service-account.json 파일을 찾을 수 없습니다."; \
		echo "💡 Google Cloud Console에서 서비스 계정 키 파일을 다운로드하고 .secrets/ 폴더에 저장하세요."; \
	fi

# GA4 API 테스트
test-ga4:
	@echo "🧪 Google Analytics 4 API 테스트 중..."; \
	if [ -f "test_ga4_api.js" ]; then \
		node test_ga4_api.js; \
	else \
		echo "❌ test_ga4_api.js 파일을 찾을 수 없습니다."; \
	fi

# Node.js 의존성 설치
install-deps:
	@echo "📦 Node.js 의존성 설치 중..."; \
	if [ -f "package.json" ]; then \
		npm install; \
		echo "✅ 의존성 설치 완료!"; \
	else \
		echo "❌ package.json 파일을 찾을 수 없습니다."; \
	fi
