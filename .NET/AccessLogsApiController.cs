using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.AccessLogs;
using Sabio.Models.Requests.AccessLogs;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/accesslogs")]
    [ApiController]
    public class AccessLogsApiController : BaseApiController
    {
        private IAccessLogsService _service = null;
        private IAuthenticationService<int> _authService = null;

        public AccessLogsApiController(IAccessLogsService service
            ,ILogger<AccessLogsApiController> logger
            , IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
        }

        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(AccessLogAddRequest model)
        {
            ObjectResult result = null;

            try
            {
                int id = _service.Add(model);
                ItemResponse<int> response = new ItemResponse<int>() { Item = id };

                result = Created201(response);
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);

                result = StatusCode(500, response);
            }
            return result;
        }
        
        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<AccessLogs>> Get(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                AccessLogs accessLog = _service.Get(id);

                if(accessLog == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<AccessLogs> { Item = accessLog };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);
        }
        
        [HttpGet("dated")]
        public ActionResult<ItemResponse<Paged<AccessLogs>>> DateRangePagination(int pageIndex, int pageSize, DateTime startDate, DateTime endDate)
        {
            ActionResult result = null;

            try
            {
                Paged<AccessLogs> paged = _service.DateRangePagination(pageIndex, pageSize, startDate, endDate);
                if(paged == null)
                {
                    result = NotFound404(new ErrorResponse("Records Not Found"));
                }
                else
                {
                    ItemResponse<Paged<AccessLogs>> response = new ItemResponse<Paged<AccessLogs>>();
                    response.Item = paged;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
            }

            return result;
        }
        
        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<AccessLogs>>> GetAllPagination(int pageIndex, int pageSize)
        {
            ActionResult result = null;

            try
            {
                Paged<AccessLogs> paged = _service.GetAllPagination(pageIndex, pageSize);
                if(paged == null)
                {
                    result = NotFound404(new ErrorResponse("Records Not Found"));
                }
                else
                {
                    ItemResponse<Paged<AccessLogs>> response = new ItemResponse<Paged<AccessLogs>>();
                    response.Item = paged;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
            }
            return result;
        }

        [HttpGet("search")]
        public ActionResult<ItemResponse<Paged<AccessLogs>>> SearchPagination(int pageIndex, int pageSize, string query)
        {
            ActionResult result = null;

            try
            {
                Paged<AccessLogs> paged = _service.SearchPagination(pageIndex, pageSize, query);
                if (paged == null)
                {
                    result = NotFound404(new ErrorResponse("Records Not Found"));
                }
                else
                {
                    ItemResponse<Paged<AccessLogs>> response = new ItemResponse<Paged<AccessLogs>>();
                    response.Item = paged;
                    result = Ok200(response);

                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
            }

            return result;
        }
    }
}