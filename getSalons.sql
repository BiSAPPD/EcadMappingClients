select *, spp.status as Club
from salons as sln
left join 
	dblink('dbname=academie', 
	'select spcr.status as status, spc.id as id, spc.name as name, spc.brand_id as brand_id, spcr.salon_id as salon_id

	from special_program_club_records as spcr
	left join special_program_clubs as spc ON spcr.club_id = spc.id') AS spp (status  text, id integer, name text, brand_id  integer, salon_id  integer )
	ON
	sln.id = spp.salon_id and spp.brand_id = 7 and 
		(case  when spp.name like '%Expert%' then spp.status
			    when spp.name like '%МБК%' then   spp.status
				end)  in ('accepted', 'invited' )
	-- LP-1:ES-3:MX-5:KR-6:RD-7
