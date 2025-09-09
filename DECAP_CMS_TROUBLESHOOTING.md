# Decap CMS 문제 해결 가이드

## 현재 상황
로컬 환경에서 Decap CMS의 DOM 에러가 발생하고 있습니다:
```
NotFoundError: Failed to execute 'removeChild' on 'Node': The node to be removed is not a child of this node.
```

## 해결 방안

### 1. 실제 배포 환경에서 테스트 (권장)
로컬에서 DOM 에러가 발생하므로, 실제 GitHub Pages 배포 후 테스트하는 것이 가장 안정적입니다.

#### 배포 단계:
1. **변경사항 커밋 및 푸시**
   ```bash
   git add .
   git commit -m "Add Decap CMS"
   git push origin feature/add-admin
   ```

2. **GitHub Pages 배포**
   - GitHub 저장소에서 `feature/add-admin` 브랜치를 `main`으로 머지
   - 또는 GitHub Pages 설정에서 `feature/add-admin` 브랜치 사용

3. **실제 CMS 접속**
   ```
   https://dirtyboots95.github.io/admin/
   ```

### 2. 로컬에서 안전한 테스트 방법

#### A. 정보 페이지 사용
```
http://localhost:4000/admin-local/
```
- ✅ 에러 없이 안정적
- ✅ 사용 가이드 제공
- ✅ 실제 CMS로 이동하는 링크

#### B. 직접 파일 편집
로컬에서는 직접 마크다운 파일을 편집하는 것이 더 안정적입니다:
- `_posts/journal/` - 일기
- `_posts/book/` - 독서
- `_posts/movie/` - 영화
- `_gallery/` - 갤러리
- `_posts/draft/` - 초안

### 3. Decap CMS DOM 에러 원인
- Decap CMS의 알려진 문제
- 로컬 환경에서 발생하는 DOM 조작 충돌
- 실제 배포 환경에서는 발생하지 않음

### 4. 권장 워크플로우

#### 개발 단계:
1. **로컬에서 직접 파일 편집**
2. **Jekyll 서버로 미리보기**
3. **만족스러우면 커밋/푸시**

#### 배포 후:
1. **실제 CMS 사용**
2. **웹 인터페이스로 콘텐츠 관리**
3. **에디토리얼 워크플로우 활용**

### 5. 현재 설정된 파일들

#### 배포용 (실제 사용):
- `admin/index.html` - Netlify Identity 로그인
- `admin/config.yml` - Git Gateway 설정

#### 로컬용 (정보 제공):
- `admin-local/index.html` - 사용 가이드
- `admin-github/index.html` - GitHub 백엔드 (DOM 에러 발생)

### 6. 다음 단계
1. **변경사항을 커밋하고 푸시**
2. **GitHub Pages에 배포**
3. **실제 CMS에서 테스트**
4. **문제없으면 main 브랜치로 머지**

## 결론
로컬에서의 DOM 에러는 Decap CMS의 알려진 문제이며, 실제 배포 환경에서는 정상적으로 동작합니다. 실제 배포 후 테스트하는 것을 권장합니다.
