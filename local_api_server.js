#!/usr/bin/env node

// 로컬 GA4 API 서버
// Jekyll 로컬 테스트용

const http = require('http');
const url = require('url');

// GA4 API 응답 데이터 (실제 테스트 결과 기반)
const mockGA4Data = {
  total_visitors: 1,
  today_visitors: 0,
  total_pageviews: 3,
  last_updated: new Date().toISOString(),
  source: 'Local Mock API'
};

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  
  // CORS 헤더 설정
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Content-Type', 'application/json');
  
  // OPTIONS 요청 처리 (CORS preflight)
  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }
  
  // GA4 Analytics API 엔드포인트
  if (parsedUrl.pathname === '/api/ga4-analytics') {
    const { property_id } = parsedUrl.query;
    
    if (!property_id) {
      res.writeHead(400);
      res.end(JSON.stringify({
        error: 'property_id is required',
        message: 'GA4 Property ID가 필요합니다.'
      }));
      return;
    }
    
    console.log(`📊 GA4 API 호출: Property ID ${property_id}`);
    console.log(`📈 응답 데이터: ${JSON.stringify(mockGA4Data, null, 2)}`);
    
    res.writeHead(200);
    res.end(JSON.stringify(mockGA4Data));
    return;
  }
  
  // 기본 응답
  res.writeHead(404);
  res.end(JSON.stringify({ error: 'Not Found' }));
});

const PORT = 3001;

server.listen(PORT, () => {
  console.log('🚀 로컬 GA4 API 서버가 시작되었습니다!');
  console.log(`📍 서버 주소: http://localhost:${PORT}`);
  console.log(`🔗 API 엔드포인트: http://localhost:${PORT}/api/ga4-analytics`);
  console.log(`📊 테스트 데이터: ${JSON.stringify(mockGA4Data, null, 2)}`);
  console.log('\n💡 이제 Jekyll 사이트에서 방문자 카운터가 작동할 것입니다!');
  console.log('   브라우저에서 http://localhost:4000 에 접속해보세요.');
  console.log('\n⏹️  서버를 중지하려면 Ctrl+C를 누르세요.');
});

// 에러 처리
server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`❌ 포트 ${PORT}가 이미 사용 중입니다.`);
    console.error('💡 다른 포트를 사용하거나 기존 서버를 중지하세요.');
  } else {
    console.error('❌ 서버 오류:', err);
  }
});
