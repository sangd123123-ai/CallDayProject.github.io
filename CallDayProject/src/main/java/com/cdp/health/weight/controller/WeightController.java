package com.cdp.health.weight.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdp.health.dto.WeightDTO;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserService;
import com.cdp.health.weight.Weight;
import com.cdp.health.weight.service.WeightRepository;
import com.cdp.health.weight.service.WeightService;

@Controller
@RequestMapping("/weight")
public class WeightController {

	@Autowired
	private WeightService weightService;

	@GetMapping("/wt")
	public String weightPage(Model model, Principal principal) {
		SiteUser user = userService.getUser(principal.getName());
		List<WeightDTO> weightRecords = weightService.getWeightRecords(user.getId());
		model.addAttribute("weightRecords", weightRecords);
		model.addAttribute("siteuserid", user.getId());
		return "weightChart";
	}

	// GET 요청 처리 추가
	@GetMapping("/add")
	public String addWeightForm() {
		return "redirect:/weight/wt";
	}

	@Resource
	private WeightRepository weightRepository;

	@Resource
	private UserService userService;

	@Transactional
	@PostMapping("/add")
	public String addWeightRecord(WeightDTO dto, Principal principal) {

		SiteUser user = userService.getUser(principal.getName());

		Weight w = new Weight();
		w.setSiteuser(user);
		w.setCurrentweight(dto.getCurrentweight());
		w.setRecorddate(dto.getRecorddate() != null ? dto.getRecorddate() : LocalDate.now());
		w.setWeightmemo(dto.getWeightmemo());
		w.setUserheight(dto.getUserheight());

		weightRepository.save(w);

		return "redirect:/weight/wt";

	}

	// 체중 기록 삭제
	@PostMapping("/delete")
	public String deleteWeight(@RequestParam("weightrecordid") int weightrecordid, 
			Principal principal, RedirectAttributes redirectAttributes) {
		try {
			SiteUser user = userService.getUser(principal.getName());

			// 해당 기록이 현재 사용자의 것인지 확인
			WeightDTO record = weightService.getWeightById(weightrecordid);
			if (record == null || !record.getSiteuserid().equals(user.getId())) {
				redirectAttributes.addFlashAttribute("error", "삭제 권한이 없습니다.");
				return "redirect:/weight/wt";
			}

			weightService.deleteWeightRecord(weightrecordid);
			redirectAttributes.addFlashAttribute("message", "기록이 삭제되었습니다.");

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
		}

		return "redirect:/weight/wt";
	}

	// 체중 기록 필드별 수정 (AJAX용)
	@PostMapping("/updateField")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateField(
			@RequestParam("weightrecordid") int weightrecordid,
			@RequestParam("field") String field,
			@RequestParam("value") String value,
			Principal principal) {

		Map<String, Object> response = new HashMap<>();

		try {
			SiteUser user = userService.getUser(principal.getName());

			// 해당 기록이 현재 사용자의 것인지 확인
			WeightDTO record = weightService.getWeightById(weightrecordid);
			if (record == null || !record.getSiteuserid().equals(user.getId())) {
				response.put("success", false);
				response.put("message", "수정 권한이 없습니다.");
				return ResponseEntity.badRequest().body(response);
			}

			// 필드별로 유효성 검사 및 값 설정
			switch (field) {
			case "currentweight":
				try {
					double weight = Double.parseDouble(value);
					if (weight <= 0 || weight > 300) {
						throw new IllegalArgumentException("체중은 0~300kg 사이여야 합니다.");
					}
					record.setCurrentweight(weight);
				} catch (NumberFormatException e) {
					response.put("success", false);
					response.put("message", "올바른 체중을 입력해주세요.");
					return ResponseEntity.badRequest().body(response);
				}
				break;

			case "userheight":
				try {
					int height = Integer.parseInt(value);
					if (height < 100 || height > 250) {
						throw new IllegalArgumentException("키는 100~250cm 사이여야 합니다.");
					}
					record.setUserheight(height);
				} catch (NumberFormatException e) {
					response.put("success", false);
					response.put("message", "올바른 키를 입력해주세요.");
					return ResponseEntity.badRequest().body(response);
				}
				break;

			case "recorddate":
				try {
					LocalDate date = LocalDate.parse(value);
					record.setRecorddate(date);
				} catch (Exception e) {
					response.put("success", false);
					response.put("message", "올바른 날짜를 입력해주세요.");
					return ResponseEntity.badRequest().body(response);
				}
				break;

			case "weightmemo":
				record.setWeightmemo(value.trim().isEmpty() ? null : value.trim());
				break;

			default:
				response.put("success", false);
				response.put("message", "잘못된 필드입니다.");
				return ResponseEntity.badRequest().body(response);
			}

			// 데이터베이스 업데이트
			weightService.updateWeightRecord(record);

			response.put("success", true);
			response.put("message", "수정되었습니다.");

		} catch (IllegalArgumentException e) {
			response.put("success", false);
			response.put("message", e.getMessage());
			return ResponseEntity.badRequest().body(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "수정 중 오류가 발생했습니다.");
			return ResponseEntity.internalServerError().body(response);
		}

		return ResponseEntity.ok(response);
	}

	// 전체 기록 수정 (폼 기반)
	@PostMapping("/update")
	public String updateWeight(WeightDTO weightDTO, 
			Principal principal, RedirectAttributes redirectAttributes) {
		try {
			SiteUser user = userService.getUser(principal.getName());

			// 해당 기록이 현재 사용자의 것인지 확인
			WeightDTO existingRecord = weightService.getWeightById(weightDTO.getWeightrecordid());
			if (existingRecord == null || !existingRecord.getSiteuserid().equals(user.getId())) {
				redirectAttributes.addFlashAttribute("error", "수정 권한이 없습니다.");
				return "redirect:/weight/wt";
			}

			weightDTO.setSiteuserid(user.getId());
			weightService.updateWeightRecord(weightDTO);
			redirectAttributes.addFlashAttribute("message", "기록이 수정되었습니다.");

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "수정 중 오류가 발생했습니다.");
		}

		return "redirect:/weight/wt";
	}

	// 수정 폼 페이지 (선택사항)
	@GetMapping("/edit")
	public String editWeightForm(@RequestParam("weightrecordid") int weightrecordid,
			Model model, Principal principal,
			RedirectAttributes redirectAttributes) {
		try {
			SiteUser user = userService.getUser(principal.getName());
			WeightDTO record = weightService.getWeightById(weightrecordid);

			if (record == null || !record.getSiteuserid().equals(user.getId())) {
				redirectAttributes.addFlashAttribute("error", "수정 권한이 없습니다.");
				return "redirect:/weight/wt";
			}

			model.addAttribute("weightRecord", record);
			return "weightEdit";

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "기록을 불러오는 중 오류가 발생했습니다.");
			return "redirect:/weight/wt";
		}

	}

}