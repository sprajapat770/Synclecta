# Synclecta Project Architecture

## 📁 Quick Navigation
- **[PROJECT_INDEX.md](PROJECT_INDEX.md)** - Central project navigation hub
- **[README.md](README.md)** - Project overview and quick start
- **[.cursor/rules/project-implementation.mdc](.cursor/rules/project-implementation.mdc)** - 28-week implementation plan
- **[.cursor/rules/synclecta-rules.mdc](.cursor/rules/synclecta-rules.mdc)** - Development standards

## Project Overview
Synclecta is a Laravel-based composer package ecosystem for centralized e-commerce data management with multi-platform integration and custom API/webhook flow builder.

## Architecture Decisions

### 1. Package Architecture - Hybrid Approach
```
synclecta/
├── core/ (monorepo)
│   ├── auth/ - Authentication package
│   ├── permissions/ - Role-based access control
│   ├── api-builder/ - Custom API endpoint builder
│   ├── webhook-builder/ - Flow builder (Celigo-like)
│   └── admin-dashboard/ - Laravel Blade + Tailwind CSS
├── connectors/ (separate repos)
│   ├── shopify-connector/ - Shopify integration
│   ├── bigcommerce-connector/ - BigCommerce integration
│   └── magento-connector/ - Magento 2 integration
└── shared/ (monorepo)
    ├── core-models/ - Unified data models
    ├── data-transformer/ - Data transformation layer
    └── sync-engine/ - Real-time synchronization
```

### 2. E-commerce Data Scope - Full Sync + Custom Fields
**Data Entities:**
- Products (with custom fields as JSON)
- Orders (with custom fields as JSON)
- Customers (with custom fields as JSON)
- Inventory (with custom fields as JSON)
- Categories (with custom fields as JSON)
- Custom Fields (platform-specific validation)

**Field Mapping:**
- Visual field mapping interface
- Platform-specific field validation
- Custom field transformation rules

### 3. API Builder Scope
**REST API Support:**
- Custom endpoint creation
- Request/response handling
- Middleware management
- API versioning (v1, v2, etc.)
- Rate limiting and throttling

**GraphQL Support:**
- GraphQL schema builder
- Custom resolvers
- Type definitions
- Query optimization

**Webhook Endpoints:**
- Custom webhook receivers
- Webhook validation
- Webhook security (signatures)
- Webhook retry mechanisms

### 4. Multi-tenancy - Isolated Databases
**Database Strategy:**
- Database per tenant
- Dynamic database connections
- Tenant-specific migrations
- Isolated data storage
- Tenant management interface

**Connection Management:**
- Dynamic database switching
- Connection pooling
- Tenant context middleware
- Database creation automation

### 5. Deployment Strategy - Self-hosted (On-premise)
**Infrastructure:**
- Docker containerization
- MySQL 8.0 databases
- Redis for caching/queues
- Nginx web server
- PHP 8.2 FPM

**Scaling:**
- Horizontal scaling ready
- Load balancer support
- Database clustering
- Queue worker scaling

### 6. Frontend Requirements - Admin Dashboard
**Technology Stack:**
- Laravel Blade views
- Tailwind CSS for styling
- Alpine.js for interactivity
- Livewire for real-time updates

**Dashboard Features:**
- Tenant management interface
- Connector configuration
- Flow designer (drag-and-drop)
- Data monitoring and analytics
- User and permission management
- System health monitoring

### 7. Integration Priority - All Platforms
**Connector Strategy:**
- Independent connector packages
- Platform-specific SDKs
- Unified data models
- Consistent API interfaces
- Extensible architecture

**Platform Support:**
- Shopify (OAuth 2.0)
- BigCommerce (OAuth 2.0)
- Magento 2 (REST API)
- Future: WooCommerce, PrestaShop, etc.

### 8. Data Flow Complexity - Two-way Sync
**Sync Strategy:**
- Real-time webhook processing
- Batch processing for large datasets
- Conflict resolution algorithms
- Data transformation layer
- Audit logging system

**Flow Builder Scope (My Decisions):**
- **Trigger Nodes:** Webhook, Schedule, Manual, Event
- **Action Nodes:** HTTP Request, Data Transform, Database, Platform API, Email/SMS, Condition Logic, Delay
- **Execution:** Both real-time and queued processing
- **Error Handling:** Retry logic with exponential backoff
- **Data Context:** Global variables with node-specific scopes
- **Templates:** Pre-built common workflow templates

## Technical Specifications

### Database Schema
```sql
-- Core Tables (per tenant)
users
roles
permissions
role_user
permission_role

-- API Builder Tables
api_endpoints
api_versions
api_middleware
api_logs

-- Flow Builder Tables
flows
flow_nodes
flow_executions
flow_logs

-- E-commerce Tables
products
orders
customers
inventory
categories
custom_fields

-- Sync Tables
sync_jobs
sync_logs
webhook_events
```

### API Endpoints Structure
```
/api/v1/
├── auth/
│   ├── login
│   ├── logout
│   └── refresh
├── users/
│   ├── profile
│   └── permissions
├── connectors/
│   ├── shopify/
│   ├── bigcommerce/
│   └── magento/
├── flows/
│   ├── create
│   ├── execute
│   └── monitor
└── data/
    ├── products
    ├── orders
    └── customers
```

### Security Implementation
- **OAuth 2.0** for platform authentication
- **JWT tokens** for API authentication
- **Tenant isolation** at database level
- **Role-based access control** (RBAC)
- **API rate limiting** and throttling
- **Data encryption** at rest and in transit
- **Audit logging** for all operations

### Performance Requirements
- **API response time:** < 200ms
- **Concurrent users:** 1000+
- **Webhook processing:** 10,000+/hour
- **Uptime:** 99.9%
- **Error rate:** < 1%

### Monitoring & Alerts
- **Real-time sync monitoring**
- **Email/SMS alerts** for failures
- **Performance metrics** dashboard
- **System health checks**
- **Error tracking** and reporting
- **Usage analytics**

## Development Phases

### Phase 1: Foundation (Week 1-2)
- Docker environment setup
- Core package structure
- Database schema design
- Authentication system

### Phase 2: Authentication Package (Week 3-4)
- User management
- OAuth 2.0 implementation
- JWT token system
- Multi-tenant support

### Phase 3: Role Permission Package (Week 5-6)
- RBAC system
- Permission management
- Role assignment
- Dynamic permissions

### Phase 4: E-commerce Connectors (Week 7-12)
- Shopify connector
- BigCommerce connector
- Magento 2 connector
- Unified data models

### Phase 5: API Builder (Week 13-16)
- Custom endpoint creation
- GraphQL support
- Webhook endpoints
- API documentation

### Phase 6: Flow Builder (Week 17-20)
- Visual flow designer
- Node library
- Execution engine
- Flow monitoring

### Phase 7: Admin Dashboard (Week 21-22)
- Laravel Blade interface
- Tailwind CSS styling
- Real-time monitoring
- User management

### Phase 8: Testing & Deployment (Week 23-28)
- Comprehensive testing
- Performance optimization
- Security audit
- Production deployment

## Success Metrics
- **Code coverage:** 90%+
- **API response time:** < 200ms
- **System uptime:** 99.9%
- **Security:** Zero critical vulnerabilities
- **Documentation:** Complete and up-to-date

## Risk Mitigation
- **API changes:** Monitor platform updates
- **Data loss:** Comprehensive backup strategy
- **Performance:** Continuous monitoring
- **Security:** Regular audits and updates
- **Scalability:** Design for horizontal scaling

This architecture provides a solid foundation for building a scalable, secure, and feature-rich e-commerce integration platform. 