#!/bin/bash

# Google Analytics 4 환경 변수 설정 스크립트
# 사용법: source setup_env.sh

echo "🔧 Google Analytics 4 환경 변수 설정 중..."

# 현재 디렉토리 확인
if [ ! -f ".secrets/ga4-service-account.json" ]; then
    echo "❌ .secrets/ga4-service-account.json 파일을 찾을 수 없습니다."
    echo "💡 다음 단계를 따라주세요:"
    echo "   1. Google Cloud Console에서 서비스 계정 키 파일 다운로드"
    echo "   2. .secrets/ 폴더에 ga4-service-account.json으로 저장"
    exit 1
fi

# 환경 변수 설정
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/.secrets/ga4-service-account.json"
export GA4_PROPERTY_ID="503083435"
export GA4_MEASUREMENT_ID="G-H9LCES4944"
export JEKYLL_ENV="production"

echo "✅ 환경 변수 설정 완료:"
echo "   GOOGLE_APPLICATION_CREDENTIALS: $GOOGLE_APPLICATION_CREDENTIALS"
echo "   GA4_PROPERTY_ID: $GA4_PROPERTY_ID"
echo "   GA4_MEASUREMENT_ID: $GA4_MEASUREMENT_ID"
echo "   JEKYLL_ENV: $JEKYLL_ENV"
echo ""
echo "💡 이제 다음 명령어로 Jekyll을 실행할 수 있습니다:"
echo "   bundle exec jekyll serve"
echo ""
echo "⚠️  이 터미널을 닫으면 환경 변수가 초기화됩니다."
echo "   영구 설정을 원한다면 ~/.zshrc 또는 ~/.bash_profile에 추가하세요."
