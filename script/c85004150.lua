--電子光虫－ライノセバス
function c85004150.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,c85004150.mfilter,7,2,c85004150.ovfilter,aux.Stringid(85004150,0),99,c85004150.xyzop)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1e0)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c85004150.descost)
	e2:SetTarget(c85004150.destg)
	e2:SetOperation(c85004150.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCode(511002571)
	e4:SetLabel(c:GetOriginalCode())
	e4:SetLabelObject(e2)
	c:RegisterEffect(e4)
end
function c85004150.ovfilter(c,tp,xyzc)
	return c:IsFaceup() and c:IsXyzType(TYPE_XYZ) and (c:GetRank()==5 or c:GetRank()==6) and c:IsRace(RACE_INSECT)
end
function c85004150.xyzop(e,tp,chk,mc)
 	if chk==0 then return not mc or mc:CheckRemoveOverlayCard(tp,2,REASON_COST) end
	if chk==1 then
		return true
	end
	if chk==2 then
		mc:RemoveOverlayCard(tp,2,2,REASON_COST)
	end
end
function c85004150.mfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c85004150.desfilter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c85004150.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c85004150.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85004150.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c85004150.desfilter,tp,0,LOCATION_MZONE,nil)
	local dg=g:GetMaxGroup(Card.GetDefense)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c85004150.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c85004150.desfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local dg=g:GetMaxGroup(Card.GetDefense)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
